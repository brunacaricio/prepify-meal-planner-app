namespace :export do
  desc "Export to Excel"
  task to_excel: :environment do
    models = [Recipe, Ingredient, RecipeIngredient]

    Axlsx::Package.new do |p|
      models.each do |model|
        p.workbook.add_worksheet(name: model.name) do |sheet|
          columns = model.column_names
          sheet.add_row columns
          model.all.each do |record|
            sheet.add_row record.attributes.values
          end
        end
      end

      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      directory = Rails.root.join("exports")
      FileUtils.mkdir_p(directory) unless File.directory?(directory)
      file_path = directory.join("export_#{timestamp}.xlsx")
      p.serialize(file_path.to_s)

      puts "Exported to #{file_path}"
    end
  end
end
