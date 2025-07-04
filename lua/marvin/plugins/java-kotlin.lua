return {
	"mfussenegger/nvim-jdtls",
	ft = { "java", "kotlin" },
	config = function()
		local all_env_vars_present = true
		local get_env = function(env_var)
			local value = os.getenv(env_var)
			if value and value ~= "" then
				return value
			end
			all_env_vars_present = false
			vim.notify(
				"environment variable " .. env_var .. " is not present",
				vim.log.levels.ERROR,
				{ title = "nvim-jdtls Configuration Error" }
			)
		end
		local paths = {
			JAVA_PATH = get_env("JAVA_PATH"),
			JDTLS_INSTALL_LOCATION = get_env("JDTLS_INSTALL_LOCATION"),
			JDTLS_LAUNCHER_JAR = get_env("JDTLS_LAUNCHER_JAR"),
			JDTLS_CONFIG_DIR = get_env("JDTLS_CONFIG_DIR"),
			JDTLS_WORKSPACE_ROOT = get_env("JDTLS_WORKSPACE_ROOT"),
			RUNTIMES = {
				JDK21 = get_env("JDK21_HOME"),
			},
		}
		if not all_env_vars_present then
			return
		end
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = paths.JDTLS_WORKSPACE_ROOT .. "/" .. project_name
		local config = {
			cmd = {
				paths.JAVA_PATH,
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				paths.JDTLS_LAUNCHER_JAR,
				"-configuration",
				paths.JDTLS_CONFIG_DIR,
				"-data",
				workspace_dir,
			},
			root_dir = vim.fs.root(0, { "mvnw", "gradlew" }),
			settings = {
				java = {
					configuration = {
						runtimes = {
							{
								name = "JavaSE-21",
								path = paths.RUNTIMES.JDK21,
							},
						},
					},
				},
			},

			init_options = {
				bundles = {},
			},
		}
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "java", "kotlin" },
			callback = function()
				require("jdtls").start_or_attach(config)
			end,
		})
	end,
}
