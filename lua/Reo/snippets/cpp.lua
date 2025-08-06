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
			"using pii = pair<int, int>;",
			"using pll = pair<ll, ll>;",
			"using vi = vector<int>;",
			"using vll = vector<ll>;",
			"",
			"#define FOR(i, a, b) for (int i = (a); i < (b); ++i)",
			"#define REP(i, n) FOR(i, 0, n)",
			"#define EACH(x, a) for (auto& x : a)",
			"",
			"#define input(x) cin>>x",
			"",

			"#define ALL(x) (x).begin(), (x).end()",
			"#define SORT(x) sort(ALL(x))",
			"#define REV(x) reverse(ALL(x))",
			"#define SZ(x) ((int)(x).size())",
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
