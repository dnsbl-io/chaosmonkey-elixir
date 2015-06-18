defmodule Chaosmonkey do

  def kill do
    {:ok, pid} = Task.start(fn -> end)
    pid_string = :erlang.pid_to_list(pid) |> :erlang.list_to_binary
    "<" <> rest = pid_string |> String.replace(".", ",")
    {a, rest} = rest |> Integer.parse
    "," <> rest = rest
    {b, rest} = rest |> Integer.parse
    "," <> rest = rest
    {c, rest} = rest |> Integer.parse
    :random.seed(:os.timestamp)
    do_kill({a, b , c}, 1_000)
  end

  defp do_kill(_, 0), do: false

  defp do_kill({a, b, c}, max_attempts) do
    x = :random.uniform(a + 1) - 1
    y = :random.uniform(b + 1) - 1
    z = :random.uniform(c + 1) - 1
    p = "<#{x}.#{y}.#{z}>" |> String.to_char_list |> :erlang.list_to_pid
    unless :erlang.process_info(p, :status) == :undefined do
      :erlang.exit(p, 'Greetings from the chaosmonkey')
      max_attempts = 1
    end
    do_kill({a, b, c}, max_attempts - 1)
  end

end
