// cong so lon toi uu boi vu thai son
string csl(string a, string b){
    reverse(all(a));
    reverse(all(b));
    int f = a.size()-b.size();
    if (f!=0){
        string t(abs(f), '0');
        if (f<0) a+=t;
        else b+=t;
    }
    int saver=0, temp;
    for (int i = 0; i < a.size(); i++){
        temp = (a[i]-'0')+(b[i]-'0')+saver;
        a[i]=temp%10 + '0';
        saver=temp/10;
    }
    if (saver) a.push_back(saver + '0');
    reverse(all(a));
    return a;
}
/// another choice
string csl(string a, string b) {
    int carry = 0;
    int diff = a.size() - b.size();
    if (diff > 0) b.insert(b.begin(), diff, '0');
    else a.insert(a.begin(), -diff, '0');
    for (int i = a.size() - 1; i >= 0; i--) {
        int temp = a[i] - '0' + b[i] - '0' + carry;
        carry = temp / 10;
        a[i] = temp % 10 + '0';
    }
    if (carry > 0) a.insert(a.begin(), carry + '0');
    return a;
}
