defmodule VireoWeb.UploadController do
  use VireoWeb, :controller

  def presign(conn, %{"filename" => filename, "content_type" => content_type}) do
    case Vireo.Uploads.presigned_upload_url(filename, content_type) do
      {:ok, url} -> json(conn, %{url: url})
      {:error, reason} -> send_resp(conn, 500, "Error: #{inspect(reason)}")
    end
  end

  def show_video(conn, %{"filename" => filename}) do
    case Vireo.Uploads.presigned_download_url(filename) do
      {:ok, url} ->
        render(conn, "show_video.html", video_url: url)
      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> text("Video unable to play: #{inspect(reason)}")
    end
  end
end
