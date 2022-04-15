class CreatePanelConfigs < ActiveRecord::Migration[6.1]
  def change
    create_table :panel_configs do |t|
      t.text :about_desc, default: nil
      t.text :contact_desc, default: nil
      t.text :home_head_title, default: nil
      t.text :home_head_desc, default: nil
      t.text :home_pre_release_desc, default: nil
      t.text :home_releasing_desc, default: nil
      t.text :home_released_desc, default: nil
      t.timestamps
    end

    PanelConfig.create!(
      about_desc: 'Suspendisse nisl massa, tempor non diam euismod, finibus aliquam erat. Quisque dictum rhoncus est, vitae pretium elit efficitur nec. Vestibulum maximus risus quis commodo accumsan. Nullam pretium lacus arcu, semper vulputate mauris posuere sed. Vivamus lacinia rutrum arcu non malesuada. Sed feugiat, orci eu cursus ornare, sapien tortor consectetur libero, non venenatis tellus odio vitae ligula. Nullam commodo pulvinar velit a cursus. In condimentum, justo laoreet scelerisque interdum, mauris massa gravida diam, at pretium nisl risus non mauris. Sed quis ipsum at mauris rutrum pellentesque. Nulla lacus massa, suscipit eu dui mattis, dignissim rutrum leo. Aliquam dignissim fermentum massa, at tristique ligula egestas eu.',
      contact_desc: 'In condimentum, justo laoreet scelerisque interdum, mauris massa gravida diam, at pretium nisl risus non mauris. Sed quis ipsum at mauris rutrum pellentesque. Nulla lacus massa, suscipit eu dui mattis, dignissim rutrum leo.',
      home_head_title: 'First Special News Here!',
      home_head_desc: 'Sed porttitor lectus nibh. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet aliquam vel, ullamcorper sit amet ligula. Pellentesque in ipsum id orci porta dapibus. Proin eget tortor risus. Donec rutrum congue leo eget malesuada. Sed porttitor lectus nibh. Sed porttitor lectus nibh. ',
      home_pre_release_desc: 'Donec nec ultricies est. Nam tincidunt diam in tortor consequat feugiat at a nisl. Quisque eu dolor quam. Cras tincidunt sit amet massa vel accumsan. Nam maximus dignissim diam, et laoreet orci tincidunt eget. Mauris nec nibh a odio condimentum sagittis. Integer eget turpis tortor. Pellentesque varius sem at tellus rhoncus consectetur. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent interdum ultricies odio ac accumsan. Sed laoreet justo erat, vel accumsan libero consequat vitae. Integer placerat est sed molestie pretium. Fusce semper fringilla enim non viverra. Maecenas non eros est. Ut aliquam vitae purus sit amet fermentum. Curabitur hendrerit tempus felis, vel maximus massa pretium eget. ',
      home_releasing_desc: 'Praesent ut vulputate risus. Proin viverra et justo sed semper. Sed mi velit, faucibus posuere massa sodales, pellentesque accumsan odio. Nullam vel mollis turpis, pretium venenatis lorem. Nullam maximus dui dui, quis imperdiet lorem euismod sit amet. Etiam condimentum, ante eget feugiat placerat, ex turpis aliquam tellus, sit amet lobortis orci eros at velit. Fusce ut ullamcorper neque. In ut tortor felis. Nullam pretium sodales convallis. Sed nulla sapien, tempus a sollicitudin vel, egestas id nisi. ',
      home_released_desc: 'Duis lorem felis, volutpat ac iaculis ut, blandit nec mauris. Phasellus dui felis, venenatis eget tincidunt in, sagittis ac nibh. Sed fermentum porta magna, quis scelerisque sem hendrerit in. Aliquam erat volutpat. Aenean cursus egestas dui sed pellentesque. Donec luctus enim at ante fringilla, nec aliquet augue mollis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.',
    )
  end
end