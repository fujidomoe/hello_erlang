{application, hello_erlang, [
  {description, ""},
  {vsn, "0.1.0"},
  {modules, ['hello_erlang_app','hello_erlang_sup']},
  {registered, []},
  {applications, [
    kernel,
    cowboy,
    stdlib
  ]},
  {mod, {hello_erlang_app, []}},
  {env, []}
]}.
