# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

vix = File.read(Rails.root.join('lib', 'seeds', 'best_dte_otm_given_VIX_FVmean.csv'))

csv_vix = CSV.parse(vix, :headers => true, :encoding => 'ISO-8859-1')

csv_vix.each do |row|
    # row = row.to_hash
    v = Vix.new 
    v.dte = row["DTE"]
    v.otm = row["OTM"]
    v.ret = row["Return"]
    v.fvmean = row["FVmean"]
    v.vix = row["VIX"]
    v.save

end

# Vix.where(vix: some float, fvmean: someother float)
