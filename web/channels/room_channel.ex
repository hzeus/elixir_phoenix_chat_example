defmodule ChatExample.RoomChannel do
	alias ChatExample.Presence
  use ChatExample.Web, :channel

  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      send self, :after_join
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new_chat_message", %{"message" => message}, socket) do
    broadcast socket, "new_chat_message", %{message: message, user: socket.assigns.current_user}
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.current_user, %{})
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
