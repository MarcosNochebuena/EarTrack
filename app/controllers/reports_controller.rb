class ReportsController < ApplicationController
  def index
    @keys = Key.all
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "RegistroAretes_#{Time.year}", template: "reports/pdf/report.html.erb", layout: "pdf",
               page_size: "Letter",
               orientation: 'Landscape'
      end
    end
  end
end
