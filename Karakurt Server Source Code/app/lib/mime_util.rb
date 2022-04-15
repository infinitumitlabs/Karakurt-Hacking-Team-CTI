require 'mimemagic'

class MimeUtil

  def self.detect(filename)
    mime_data = MimeMagic.by_path(filename)
    mime_data.nil? ? nil : mime_data.type
  end

  def self.group_by_file(filename)
    group(detect(filename))
  end

  private

  def self.group(mime)
    case mime
    when "image/gif", "image/jpeg", "image/pjpeg", "image/png", "image/svg+xml", "image/tiff"
      return 'images'
    when "application/json", "application/javascript", "application/pdf", "application/rdf+xml", "text/cmd", "text/css", "text/csv", "text/html", "text/javascript", "text/plain", "text/vcard", "text/xml"
      return 'documents'
    when "application/ogg", "audio/basic", "audio/L24", "audio/mp4", "audio/mpeg", "audio/ogg", "audio/vorbis", "audio/vnd.rn-realaudio", "audio/vnd.wave", "audio/webm", "video/mpeg", "video/mp4", "video/ogg", "video/quicktime", "video/webm", "video/x-matroska", "video/x-ms-wmv", "video/x-flv"
      return 'media'
    when "application/zip", "application/gzip"
      return 'archives'
    else
      return 'others'
    end
  end
end