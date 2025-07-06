defmodule Vireo.Uploads do
  @bucket "throbbing-bush-8379"

  def presigned_upload_url(filename, content_type) do
    ExAws.Config.new(:s3)
    |> ExAws.S3.presigned_url(
      :put,
      @bucket,
      filename,
      expires_in: 3600, # 1 hour
      content_type: content_type
    )
  end

  def presigned_download_url(filename) do
    ExAws.Config.new(:s3)
    |> ExAws.S3.presigned_url(:get, @bucket, filename, expires_in: 3600) # 1 hour
  end
end
