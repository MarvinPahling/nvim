return {
	"mfussenegger/nvim-jdtls",
	ft = { "java", "kotlin" },
	config = function()
		local jdtls_install_location =
			"/Users/marvin/android-dev/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository"
		local paths = {
			JAVA_PATH = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home/bin/java",
			-- /path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar
			JDTLS_PATH = jdtls_install_location .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
			-- /path/to/jdtls_install_location/config_SYSTEM
			JDTLS_CONFIG_PATH = jdtls_install_location .. "/config_mac_arm",
			WORKSPACE_DIR = "/Users/marvin/android-dev",
			RUNTIMES = {
				JDK21 = "/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home",
			},
		}
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = paths.WORKSPACE_DIR .. project_name
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
				paths.JDTLS_PATH,
				"-configuration",
				paths.JDTLS_CONFIG_PATH,
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
