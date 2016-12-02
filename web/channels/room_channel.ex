defmodule ChatExample.RoomChannel do
	alias ChatExample.Presence
  use ChatExample.Web, :channel

  def join("room"<>_channel_name, payload, socket) do
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

  def handle_in("typing", _params, socket) do
    Presence.update(socket, socket.assigns.current_user, %{typing: true})
    {:noreply, socket}
  end

  def handle_in("not_typing", _params, socket) do
    Presence.update(socket, socket.assigns.current_user, %{typing: false})
    {:noreply, socket}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.current_user, %{typing: false})
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
