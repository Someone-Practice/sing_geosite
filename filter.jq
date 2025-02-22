{
	"version":3,
	"rules":[
		{
			"type": "logical",
			"mode": "and",
			"rules": [
				{
					"domain_suffix": $include[0].rules[0].domain_suffix,
					"domain": $include[0].rules[0].domain,
					"domain_regex": $include[0].rules[0].domain_regex,
					"domain_keyword": $include[0].rules[0].domain_keyword
				},
				{
					"domain_suffix": $exclude[0].rules[0].domain_suffix,
					"domain": $exclude[0].rules[0].domain,
					"domain_regex": $exclude[0].rules[0].domain_regex,
					"domain_keyword": $exclude[0].rules[0].domain_keyword,
					"invert": true
				}
			]
		}
	]
}
