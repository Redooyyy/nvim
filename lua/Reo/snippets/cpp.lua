local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
	s("cpp", {
		t({
			"#include <bits/stdc++.h>",
			"using namespace std;",

			"#define FAST_IO ios_base::sync_with_stdio(false); cin.tie(nullptr);",
			"",
			"using ll = long long;",
			"using ld = long double;",
			"",
			"#define fr(i, a, b) for (int i = (a); i < (b); ++i)",
			"#define frn(i, n) FOR(i, 0, n)",
			"",
			'#define endl "\\n" ',
			"",
			"#define ALL(x) (x).begin(), (x).end()",
			"#define sz(x) ((int)(x).size())",
			"",
			"",
			"int main() {",
			"    FAST_IO",
			"",
			"",
			"    return 0;",
			"}",
		}),
	}),
}
