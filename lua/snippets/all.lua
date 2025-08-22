---@diagnostic disable: undefined-global
return {
	s("date", t(os.date("%Y/%m/%d"))),
	s("mail", t("marvinpahling@gmail.com")),
	s("email", t("marvinpahling@gmail.com")),
	s("(", { t("("), i(1), t(")") }),
	s("[", { t("["), i(1), t("]") }),
	s("{", { t("{"), i(1), t("}") }),
	s("$", { t("$"), i(1), t("$") }),
}
