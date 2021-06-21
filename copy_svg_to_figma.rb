require 'fileutils'

def copy_file(current_location , new_location)
  begin
    FileUtils.cp( current_location , new_location)
  rescue Errno::ENOENT => e
    puts e.message
  end
end

Dir.glob('src/*').each do |category|
  new_location = "figma/" + category.gsub("src/", "")
  FileUtils.mkdir_p new_location
  
  Dir.glob(category+"/*").each do |icon|
    
    icon_name = icon.split("/",3)[2]  
    new_file_location = new_location + "/" + icon_name.gsub("_", " ") + ".svg"

    if File.exists?(icon + "/materialicons/24px.svg")
      copy_file(icon + "/materialicons/24px.svg", new_file_location)
    else
      if File.exists?(icon + "/materialiconsround/24px.svg")
        copy_file(icon + "/materialiconsround/24px.svg", new_file_location)
        if File.exists?(icon + "/materialiconstwotone/24px.svg")
          copy_file(icon + "/materialiconstwotone/24px.svg", new_file_location)
        else
          puts(icon)
        end
      end
    end
  end
end