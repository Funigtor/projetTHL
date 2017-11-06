#include <vector>
#include <iostream>

template <typename type> std::vector<type> linear (type debut, type fin, type pas) {
    std::vector<type> y;
    for (type x = debut; x <= fin; x+=pas) y.push_back(x);
    return y;
}