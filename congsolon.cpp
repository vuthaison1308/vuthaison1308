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
