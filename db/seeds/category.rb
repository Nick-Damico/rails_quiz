# SEEDING CATEGORIES
categories = [
  { name: "Computer Science", slug: "computer-science" },
  { name: "Programming", slug: "programming" },
  { name: "Networking", slug: "networking" },
  { name: "Cybersecurity", slug: "Cybersecurity" },
  { name: "Operating Systems", slug: "operating-systems" },
  { name: "Cloud Computing", slug: "cloud-computing" },
  { name: "Databases", slug: "databases" },
  { name: "Web Development", slug: "web-development" },
  { name: "Mobile Development", slug: "mobile-development" },
  { name: "DevOps", slug: "devops" },
  { name: "Hardware", slug: "hardware" },
  { name: "Mathematics", slug: "mathematics" },
  { name: "Science", slug: "science" },
  { name: "Business", slug: "business" },
  { name: "Languages", slug: "languages" },
  { name: "Miscellaneous (or General)", slug: "misc-general" }
]

categories.each do |category|
  Category.find_or_create_by!(slug: category[:slug], name: category[:name])
end
