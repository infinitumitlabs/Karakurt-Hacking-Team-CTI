module ApplicationHelper

  def draw_image(path, height)
    image_tag path, height: height
  rescue
    nil
  end

  def industries
    ["Manufacturing", "Oil & Gas", "Chemicals", "Basic Resources", "Construction & Materials", "Industrial Goods & Services", "Automobiles & Parts", "Food & Beverage", "Personal & Household Goods", "Health Care", "Retail", "Media", "Travel & Leisure", "Telecommunications", "Utilities", "Banks", "Insurance", "Real Estate", "Financial Services", "Technology"].sort
  end

  def states
    %w[new pre-release releasing released]
  end

  def company_status_color(status)
    case status
    when 'active'
      'is-success'
    when 'no active'
      'is-warning'
    else # deleted
      ''
    end
  end

  def title(text)
    content_for :title, text
  end

  def paginate_ajax(collection, params= {})
    will_paginate collection, params.merge(renderer: RemoteLinkPaginationHelper::LinkRenderer, params: { table: params[:table] })
  end

  def current_page_params
    # Modify this list to whitelist url params for linking to the current page
    request.params.slice("page", "type", "sort")
  end

  def icon_by_file_mime_type(mime)
    case mime
    when "image/gif", "image/jpeg", "image/pjpeg", "image/png", "image/svg+xml", "image/tiff"
      return 'fa-file-image'
    when "application/json", "application/javascript", "text/cmd", "text/css", "text/csv", "text/html", "text/javascript", "text/xml"
      return 'fa-file-code'
    when "application/pdf", "application/rdf+xml"
      return 'fa-file-pdf'
    when "text/plain", "text/vcard", "text/xml"
      return 'fa-file-alt'
    when "application/ogg", "audio/basic", "audio/L24", "audio/mp4", "audio/mpeg", "audio/ogg", "audio/vorbis", "audio/vnd.rn-realaudio", "audio/vnd.wave", "audio/webm"
      return 'fa-file-audio'
    when "video/mpeg", "video/mp4", "video/ogg", "video/quicktime", "video/webm", "video/x-matroska", "video/x-ms-wmv", "video/x-flv"
      return 'fa-file-video'
    when "application/zip", "application/gzip"
      return 'fa-file-archive'
    when "application/zip", "application/gzip"
      return 'fa-file-archive'
    when "application/vnd.ms-excel"
      return 'fa-file-excel'
    when "application/msword", 'application/vnd.ms-word.document.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.wordprocessingml.template'
      return 'fa-file-word'
    when 'application/vnd.ms-powerpoint', 'application/vnd.ms-powerpoint.presentation.macroEnabled.12', 'application/vnd.openxmlformats-officedocument.presentationml.presentation'
      return 'fa-file-powerpoint'
    else
      return 'fa-file'
    end
  end

  def date_or_dash(date)
    date.present? ? date.strftime('%d %b') : '-'
  end

  def status_color_class(status)
    case status
    when 'failure'
      return 'is-danger'
    when 'unzipping', 'imported', 'publishing'
      return 'is-warning'
    when 'unzipped', 'complete'
      return 'is-success'
    else
      return 'is-light'
    end
  end
end
