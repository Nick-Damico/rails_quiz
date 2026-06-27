# SEEDING CATEGORIES
# categories = [
#   { name: "Computer Science", slug: "computer-science" },
#   { name: "Programming", slug: "programming" },
#   { name: "Networking", slug: "networking" },
#   { name: "Cybersecurity", slug: "Cybersecurity" },
#   { name: "Operating Systems", slug: "operating-systems" },
#   { name: "Cloud Computing", slug: "cloud-computing" },
#   { name: "Databases", slug: "databases" },
#   { name: "Web Development", slug: "web-development" },
#   { name: "Mobile Development", slug: "mobile-development" },
#   { name: "DevOps", slug: "devops" },
#   { name: "Hardware", slug: "hardware" },
#   { name: "Mathematics", slug: "mathematics" },
#   { name: "Science", slug: "science" },
#   { name: "Business", slug: "business" },
#   { name: "Languages", slug: "languages" },
#   { name: "Miscellaneous (or General)", slug: "misc-general" }
# ]

categories = [
  { name: "Technology", slug: "technology" },
  { name: "Science", slug: "science" },
  { name: "Mathematics", slug: "mathematics" },
  { name: "History", slug: "history" },
  { name: "Geography", slug: "geography" },
  { name: "Language", slug: "language" },
  { name: "Literature", slug: "literature" },
  { name: "Business", slug: "business" },
  { name: "Finance", slug: "finance" },
  { name: "Health & Medicine", slug: "health-medicine" },
  { name: "Law", slug: "law" },
  { name: "Engineering", slug: "engineering" },
  { name: "Arts", slug: "arts" },
  { name: "Music", slug: "music" },
  { name: "Philosophy", slug: "philosophy" },
  { name: "Psychology", slug: "psychology" },
  { name: "Education", slug: "education" },
  { name: "Hobbies", slug: "hobbies" },
  { name: "Sports", slug: "sports" },
  { name: "General", slug: "general" }
]

categories.each do |category|
  Category.find_or_create_by!(slug: category[:slug], name: category[:name])
end
