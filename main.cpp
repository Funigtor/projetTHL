#include <nan.h>
#include <cstdlib>
#include <ctime>
#include <vector>
#include <json/json.h>
#include <string>
#include <iostream>
#include <sstream>
#include <fstream>
#include "test_func.h"

// Fonction de test avec arguments

std::vector<double> fToCalc(){
    system("./calculette /tmp/fCALC > /tmp/raiponce");
    std::vector<double> result;
    double tmp;
    // On teste la syntaxe
    std::ifstream syntax("/tmp/raiponce");
    std::string testStr;
    getline(syntax,testStr);
    syntax.close();
    if (testStr == "syntax error")result.push_back(-1.0); // Juste -1 déclanche LolNope
    else {
        std::ifstream file("/tmp/raiponce");
        while (file >> tmp) result.push_back(tmp);
    }
    return result;
}

template<typename type> std::string vectToJson(std::vector<type> tabCpp){
    // Maintenant on va essayer de sortir un JSON.
    Json::Value sandwich;
    Json::Value duCul;
    for (auto j : tabCpp) duCul.append(j);
    sandwich["points"] = duCul;
    sandwich["min"] = *std::min_element(std::begin(tabCpp), std::end(tabCpp));
    sandwich["max"] = *std::max_element(std::begin(tabCpp), std::end(tabCpp));
    // Return string
    std::stringstream result; result << sandwich; 
    return result.str();
}

NAN_METHOD(plot){
    if (info.Length() != 3) {
        Nan::ThrowTypeError("Wrong number of arguments");
        return;
      }
    
      if (!info[1]->IsNumber() || !info[2]->IsNumber()) {
        Nan::ThrowTypeError("Wrong arguments");
        return;
    }
    v8::String::Utf8Value fonction(info[0]->ToString());
    std::string fString = std::string(*fonction);
    double debut = info[1]->NumberValue();
    double fin = info[2]->NumberValue();
    std::ofstream textDebut("/tmp/debutCALC");
    std::ofstream textFin("/tmp/finCALC");
    textDebut << debut ; textFin << fin; 
    std::ofstream textFunction("/tmp/fCALC");
    textFunction << fString;
    textFunction << "\n";
    textDebut.close(); textFin.close(); textFunction.close();
    auto graph = fToCalc();
    auto returned = Nan::New("placeholder").ToLocalChecked();
    if (graph.size() < 2 || graph.empty()) returned = Nan::New("{\"error\": true}").ToLocalChecked();
    else returned = Nan::New(vectToJson(graph)).ToLocalChecked();
    info.GetReturnValue().Set(returned);    
}

// On va essayer de créer un tableau random
NAN_METHOD(RandTab){
    srand(time(0));
    std::vector<int> tabCpp;
    const int numValues = 1000;
    for (int i = 0; i < numValues; ++i ){
        tabCpp.push_back(rand() %500);
    }
    auto returned = Nan::New(vectToJson(tabCpp)).ToLocalChecked();
    info.GetReturnValue().Set(returned);
}

// NAN_METHOD is a Nan macro enabling convenient way of creating native node functions.
// It takes a method's name as a param. By C++ convention, I used the Capital cased name.
NAN_METHOD(Hello) {
    // Create an instance of V8's String type
    auto message = Nan::New("Hello from C++!").ToLocalChecked();
    // 'info' is a macro's "implicit" parameter - it's a bridge object between C++ and JavaScript runtimes
    // You would use info to both extract the parameters passed to a function as well as set the return value.
    info.GetReturnValue().Set(message);
}

// Module initialization logic
NAN_MODULE_INIT(Initialize) {
    // Export the `Hello` function (equivalent to `export function Hello (...)` in JS)
    NAN_EXPORT(target, Hello);
    NAN_EXPORT(target, RandTab);
    NAN_EXPORT(target, plot);
}

// Create the module called "addon" and initialize it with `Initialize` function (created with NAN_MODULE_INIT macro)
NODE_MODULE(addon, Initialize);
