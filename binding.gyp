{
  "targets": [
    {
      "include_dirs" : [
        "<!(node -e \"require('nan')\")"
      ],
      "target_name": "addon",
      "sources": [ "main.cpp", "jsoncpp.cpp"],
      'cflags': [ '-fexceptions' ],
      'cflags_cc': [ '-fexceptions' ]
    }
  ]
}