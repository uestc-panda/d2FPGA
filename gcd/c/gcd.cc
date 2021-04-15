#include <iostream>

using namespace std;

int main() {
    int a, b, c;
    cin >> a >> b;
    while (b) {
        if (b > a) {
            c = b;
            b = a;
            a = c;
        } else {
            a -= b;
        }
    }
    cout << a << endl;
    return 0;
}

// int main() {
//     int a, b;
//     cin >> a >> b;
//     while (a != b) {
//         if (a > b) 
//             a = a - b;
//         else 
//             b = b - a;
//     }
//     cout << a << endl;
//     return 0;
// }

// int main() {
//     int a, b, c;
//     cin >> a >> b;
//     while (b) {
//         c = a % b;
//         a = b;
//         b = c;
//     }
//     cout << a << endl;
//     return 0;
// }
