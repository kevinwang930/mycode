def _var_providing_rule_impl(ctx):
  return [
      platform_common.TemplateVariableInfo({
          ctx.attr.var_key: ctx.attr.var_value,
      }),
  ]

var_providing_rule = rule(
    implementation = _var_providing_rule_impl,
    attrs = { "var_value": attr.string(),
                "var_key":attr.string() }
)

