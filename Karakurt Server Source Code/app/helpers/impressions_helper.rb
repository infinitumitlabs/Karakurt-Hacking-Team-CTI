module ImpressionsHelper

  def title_link(impression_obj)

    case impression_obj.impressionable_type
    when 'Company'
      return 'NULL' if impression_obj.impressionable_id.nil?
      company = Company.find_by_id(impression_obj.impressionable_id)
      link_to company.name, admin_company_by_id_path(company.id)
    when 'PressRelease'
      return 'NULL' if impression_obj.impressionable_id.nil?
      press_release = PressRelease.find(impression_obj.impressionable_id)
      link_to press_release.title, admin_press_release_path(press_release.id)
    when 'Public'
      if impression_obj.action_name == 'index'
        link_to 'Main', root_path
      elsif impression_obj.action_name == 'about'
        link_to 'About', about_path
      elsif impression_obj.action_name == 'contact_us'
        link_to 'Contact Us', contact_us_path
      elsif impression_obj.action_name == 'auction'
        link_to 'Auction', auction_path
      end
    else
      '-'
    end
  end

  def title_badge(impression_obj)
    case impression_obj.impressionable_type
    when 'Company'
      'C'
    when 'PressRelease'
      'N'
    when 'Public'
      'P'
    else
      ''
    end
  end

  def status_badge(impression_obj)
    status = title_badge(impression_obj)
    case status
    when 'C'
      return 'is-danger'
    when 'N'
      return 'is-warning'
    when 'P'
      return 'is-success'
    else
      return 'is-light'
    end
  end

  def params_list(impression_obj)
    if impression_obj.params.present?
      impression_obj.params.reject! { |p| p['uuid'].present? }
    else
      {}
    end
  end
end
