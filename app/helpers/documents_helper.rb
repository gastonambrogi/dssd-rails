module DocumentsHelper
  def get_doc_url(key)
    "https://docs.google.com/document/d/#{key}/edit?usp=drivesdk"
  end
end
