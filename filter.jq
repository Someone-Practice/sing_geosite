# TODO: this is idiotic.
($include[0].rules[0].domain // []) as $domain_include |
($include[0].rules[0].domain_suffix // []) as $suffix_include |
($include[0].rules[0].domain_keyword // []) as $keyword_include |
($include[0].rules[0].domain_regex // []) as $regex_include |
($exclude[0].rules[0].domain // []) as $domain_exclude |
($exclude[0].rules[0].domain_suffix // []) as $suffix_exclude |
($exclude[0].rules[0].domain_keyword // []) as $keyword_exclude |
($exclude[0].rules[0].domain_regex // []) as $regex_exclude |
def intersection(array_1; array_2):
	(array_1 | unique | map({(.): true}) | add) as $keymap
	| array_2 | unique | map(select($keymap[.]));
($domain_include - intersection($domain_include; $suffix_include)) as $domain_merged_include |
($domain_exclude - intersection($domain_exclude; $suffix_exclude)) as $domain_merged_exclude |
intersection($domain_merged_include; $domain_merged_exclude) as $domain_intersection |
intersection($suffix_include; $suffix_exclude) as $suffix_intersection |
intersection($keyword_include; $keyword_exclude) as $keyword_intersection |
intersection($regex_include; $regex_exclude) as $regex_intersection |
{
	"version": 3,
	"rules":[
		{
			"type": "logical",
			"mode": "and",
			"rules": [
				{
					# "domain_intersection": $domain_intersection,
					# "domain_suffix_intersection": $suffix_intersection,
					# "domain_keyword_intersection": $keyword_intersection,
					# "domain_regex_intersection": $regex_intersection,
					"domain": ($domain_merged_include - $domain_intersection) | sort,
					"domain_suffix": ($suffix_include - $suffix_intersection) | sort,
					"domain_keyword": ($keyword_include - $keyword_intersection)| sort,
					"domain_regex": ($regex_include - $regex_intersection) | sort
				},
				{
					"domain": ($domain_merged_exclude - $domain_intersection) | sort,
					"domain_suffix": ($suffix_exclude - $suffix_intersection) | sort,
					"domain_keyword": ($keyword_exclude - $keyword_intersection) | sort,
					"domain_regex": ($regex_exclude - $keyword_intersection) | sort,
					"invert": true
				}
			]
		}
	]
}