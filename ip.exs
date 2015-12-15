defmodule IP do
  @doc """
    Fetch the remote IP address of this machine.
  """
  def external do
    :inets.start()
    case :httpc.request 'http://ipecho.net/plain' do
      {:ok,{{_,200,_},_,content}} ->
        content
      _ ->
        "0.0.0.0"
    end
  end

  @doc """
    Get the IP address of this machine on the local network.

    This is only confirmed working on OS X.
  """
  def local do
    [[_,local]|_] = get_ip_addresses
    local
  end

  @doc """
    Get the IP address of the router on the local network.

    This is only confirmed working on OS X.
  """
  def router do
    [_,router] = List.last(get_ip_addresses)
    router
  end

  # Strip the local and router IP addresses from the ipconfig output
  defp get_ip_addresses do
    {config, exit_status} = ipconfig("en1")
    if exit_status != 0 do
      {config, exit_status} = ipconfig("en0")
    end
    if exit_status != 0 do
      raise "Both en1 and en0 interfaces are non-responsive. (`ipconfig getpacket {interface}`)"
    end
    Regex.scan(~r/[ys]iaddr = ([\d\.]+)/, config)
  end

  # Get the ipconfig output for a given interface
  defp ipconfig(interface) do
    System.cmd "ipconfig", ["getpacket", interface]
  end
end
