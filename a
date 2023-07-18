#include <bits/stdc++.h>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
	cin.tie(NULL); cout.tie(NULL);
	freopen("srt.INP", "r", stdin);
	freopen("srt.OUT", "w", stdout);
    string s;
    cin >> s;
    stack<char> st;
    for (char c : s) {
        if (!st.empty() && st.top() == c) {
            st.pop();
        } else {
            st.push(c);
        }
    }
    if (st.empty()) {
        cout << "Empty String" << endl;
    } else {
        string result = "";
        while (!st.empty()) {
            result = st.top() + result;
            st.pop();
        }
        cout << result << endl;
    }
    return 0;
}
