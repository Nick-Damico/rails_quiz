# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

return unless Rails.env.development?

puts "SEEDING AUTHORS"

user_1 = FactoryBot.create(
  :user,
  bio: "Junior Ruby on Rails developer that is eager to learn and grow in the field of software development.",
  username: "Sam Puppers",
  email: "sam_pups@quizit.com",
  rank: :study_warrior,
  password: "1234Sammy",
  password_confirmation: "1234Sammy"
)

user_2 = FactoryBot.create(
  :user,
  username: Faker::Artist.name,
  email: Faker::Internet.email(domain: 'gmail.com'),
  bio: "Comic book enthusiast and aspiring physician that loves learning.",
  rank: :dedicated_learner,
  password: "usr2Faker",
  password_confirmation: "usr2Faker"
)

user_1.avatar.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "avatar_1.jpg")),
                     filename: "avatar_1.jpg",
                     content_type: "image/jpeg")

user_2.avatar.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "avatar_2.jpg")),
                     filename: "avatar_2.jpg",
                     content_type: "image/jpeg")

puts "SEEDING QUIZZES & QUESTIONS"

quiz_1 = Quiz.create!(
  title: "Ruby Data Types",
  description: "Test your knowledge of fundamental Ruby data types and their practical applications. Perfect for Junior Ruby on Rails developers preparing for interviews or honing their skills.",
  author: user_1
)

quiz_2 = Quiz.create!(
  title: "Fundamentals of Data Structures",
  description: "Assess your understanding of essential data structures and their applications. This quiz is designed for junior developers looking to strengthen their foundational knowledge.",
  author: user_1
)

quiz_1.questions.create!([
  {
    content: "What is a Symbol in Ruby?",
    choices_attributes: [
      { content: "A mutable string", correct: false },
      { content: "An immutable string", correct: true },
      { content: "A boolean value", correct: false }
    ]
  },
  {
    content: "What is the main difference between a String and a Symbol in Ruby?",
    choices_attributes: [
      { content: "Strings are mutable, Symbols are immutable", correct: true },
      { content: "Symbols are mutable, Strings are immutable", correct: false },
      { content: "There is no difference", correct: false }
    ]
  },
  {
    content: "What data type does the `nil` object represent?",
    choices_attributes: [
      { content: "Object", correct: false },
      { content: "String", correct: false },
      { content: "NilClass", correct: true }
    ]
  },
  {
    content: "Which of the following is a valid Integer in Ruby?",
    choices_attributes: [
      { content: "'42'", correct: false },
      { content: "42", correct: true },
      { content: "42.0", correct: false }
    ]
  },
  {
    content: "What is the data type of the value returned by `2.5 + 1`?",
    choices_attributes: [
      { content: "Integer", correct: false },
      { content: "String", correct: false },
      { content: "Float", correct: true }
    ]
  },
  {
    content: "What method converts a string to an integer in Ruby?",
    choices_attributes: [
      { content: "to_i", correct: true },
      { content: "to_int", correct: false },
      { content: "to_integer", correct: false }
    ]
  },
  {
    content: "What data type is a Range in Ruby?",
    choices_attributes: [
      { content: "Array", correct: false },
      { content: "Range", correct: true },
      { content: "Hash", correct: false }
    ]
  },
  {
    content: "What does the `is_a?` method do in Ruby?",
    choices_attributes: [
      { content: "Converts an object to another class", correct: false },
      { content: "Checks if an object is an instance of a specific class", correct: true },
      { content: "Checks if an object is nil", correct: false }
    ]
  },
  {
    content: "What is the result of `['a', 'b', 'c'].join(',')`?",
    choices_attributes: [
      { content: "'a,b,c'", correct: true },
      { content: "['a', 'b', 'c']", correct: false },
      { content: "'abc'", correct: false }
    ]
  },
  {
    content: "What does the `to_h` method do in Ruby?",
    choices_attributes: [
      { content: "Converts a string to a hash", correct: false },
      { content: "Converts a hash to a string", correct: false },
      { content: "Converts an enumerable to a hash", correct: true }
    ]
  }
])

quiz_2.questions.create!([
  {
    content: "What is the time complexity of accessing an element by index in an array?",
    choices_attributes: [
      { content: "O(1)", correct: true },
      { content: "O(n)", correct: false },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "Which data structure uses a FIFO (First In, First Out) approach?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Heap", correct: false }
    ]
  },
  {
    content: "What is the main advantage of using a hash table?",
    choices_attributes: [
      { content: "Fast lookups by key", correct: true },
      { content: "Low memory usage", correct: false },
      { content: "Simpler implementation compared to arrays", correct: false }
    ]
  },
  {
    content: "Which data structure is best suited for implementing undo functionality?",
    choices_attributes: [
      { content: "Queue", correct: false },
      { content: "Stack", correct: true },
      { content: "Array", correct: false }
    ]
  },
  {
    content: "What is the time complexity of searching for an element in a balanced binary search tree?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(log n)", correct: true },
      { content: "O(n^2)", correct: false }
    ]
  },
  {
    content: "Which data structure is commonly used for graph traversal in breadth-first search?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Priority Queue", correct: false }
    ]
  },
  {
    content: "In a linked list, what is the time complexity of inserting a new node at the beginning?",
    choices_attributes: [
      { content: "O(n)", correct: false },
      { content: "O(1)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "What is the primary difference between a stack and a queue?",
    choices_attributes: [
      { content: "Stack is LIFO, Queue is FIFO", correct: true },
      { content: "Stack is FIFO, Queue is LIFO", correct: false },
      { content: "Stack uses arrays, Queue uses linked lists", correct: false }
    ]
  },
  {
    content: "Which of the following is a self-balancing binary search tree?",
    choices_attributes: [
      { content: "Binary Heap", correct: false },
      { content: "AVL Tree", correct: true },
      { content: "Hash Table", correct: false }
    ]
  },
  {
    content: "What is the space complexity of a hash table in the worst-case scenario?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(n)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  }
])
quiz_2 = Quiz.create!(
  title: "Fundamentals of Data Structures",
  description: "Assess your understanding of essential data structures and their applications. This quiz is designed for junior developers looking to strengthen their foundational knowledge.",
  author: user_1
)

quiz_2.questions.create!([
  {
    content: "What is the time complexity of accessing an element by index in an array?",
    choices_attributes: [
      { content: "O(1)", correct: true },
      { content: "O(n)", correct: false },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "Which data structure uses a FIFO (First In, First Out) approach?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Heap", correct: false }
    ]
  },
  {
    content: "What is the main advantage of using a hash table?",
    choices_attributes: [
      { content: "Fast lookups by key", correct: true },
      { content: "Low memory usage", correct: false },
      { content: "Simpler implementation compared to arrays", correct: false }
    ]
  },
  {
    content: "Which data structure is best suited for implementing undo functionality?",
    choices_attributes: [
      { content: "Queue", correct: false },
      { content: "Stack", correct: true },
      { content: "Array", correct: false }
    ]
  },
  {
    content: "What is the time complexity of searching for an element in a balanced binary search tree?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(log n)", correct: true },
      { content: "O(n^2)", correct: false }
    ]
  },
  {
    content: "Which data structure is commonly used for graph traversal in breadth-first search?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Priority Queue", correct: false }
    ]
  },
  {
    content: "In a linked list, what is the time complexity of inserting a new node at the beginning?",
    choices_attributes: [
      { content: "O(n)", correct: false },
      { content: "O(1)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "What is the primary difference between a stack and a queue?",
    choices_attributes: [
      { content: "Stack is LIFO, Queue is FIFO", correct: true },
      { content: "Stack is FIFO, Queue is LIFO", correct: false },
      { content: "Stack uses arrays, Queue uses linked lists", correct: false }
    ]
  },
  {
    content: "Which of the following is a self-balancing binary search tree?",
    choices_attributes: [
      { content: "Binary Heap", correct: false },
      { content: "AVL Tree", correct: true },
      { content: "Hash Table", correct: false }
    ]
  },
  {
    content: "What is the space complexity of a hash table in the worst-case scenario?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(n)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  }
])

quiz_comics = Quiz.create!(
  title: "Comic Book Knowledge",
  description: "Test your knowledge of comic book history, characters, and publishers! This quiz covers both classic and modern comic book lore.",
  author: user_2
)

quiz_comics.questions.create!([
  {
    content: "Which comic book company introduced Spider-Man?",
    choices_attributes: [
      { content: "Marvel Comics", correct: true },
      { content: "DC Comics", correct: false },
      { content: "Image Comics", correct: false }
    ]
  },
  {
    content: "What is Superman’s home planet?",
    choices_attributes: [
      { content: "Krypton", correct: true },
      { content: "Mars", correct: false },
      { content: "Asgard", correct: false }
    ]
  },
  {
    content: "Who is the archenemy of Batman?",
    choices_attributes: [
      { content: "The Joker", correct: true },
      { content: "Lex Luthor", correct: false },
      { content: "Doctor Doom", correct: false }
    ]
  },
  {
    content: "What is the name of Thor’s enchanted hammer?",
    choices_attributes: [
      { content: "Mjolnir", correct: true },
      { content: "Stormbreaker", correct: false },
      { content: "Excalibur", correct: false }
    ]
  },
  {
    content: "Which superhero team includes characters like Cyclops, Wolverine, and Storm?",
    choices_attributes: [
      { content: "X-Men", correct: true },
      { content: "The Avengers", correct: false },
      { content: "The Justice League", correct: false }
    ]
  }
])

puts "SEEDING DECKS & FLASHCARDS"

## USER_1 DECKS
deck_1 = user_1.authored_decks.create!(
  title: 'Design Patterns',
  description: 'An introductory set of flashcards to help identify and understand common design patterns in software development.',
)
deck_1.cards.create!([
  {
    front: "Name the 3 categories of design patterns",
    back: "Behavioral, Creational, and Structural"
  }
])

deck_2 = user_1.authored_decks.create!(
  title: "A+ 220-1101 Cloud Models & Characteristics",
  description: "Cloud computing models and Characteristics outlined by the CompTIA A+ 220-1101 exam."
)

deck_2.cards.create!([
  { front: "Define Public Cloud", back: "Available to everyone over the internet." },
  { front: "Define Private Cloud", back: "You own and run in a data center. Your own virtualized local data center." },
  { front: "Define Hybrid Cloud", back: "A mix of both public and private." },
  { front: "Define Community Cloud", back: "Several organizations share teh same resources, this helps decrease the cost of maintaing a private cloud." },
  { front: "Iass", back: "Insfrastructure as a Service" },
  { front: "PaaS", back: "Platform as a Service" },
  { front: "SaaS", back: "Software as a Service" }
])

## USER_2 DECKS

deck_3 = user_2.authored_decks.create!(
  title: 'Common Networking / Security / Infrastructure Acronyms in A+ ',
  description: "These are common acronyms you'll encounter in the A+ 1101-1202 exam, compiled from Professor Messer's A+ course"
)

deck_3.cards.create!([
  { front: "AAA", back: "Authentication, Authorization, and Accounting - A login server." },
  { front: "ACL", back: "Access Control List - A set of predefined security rules that acts as a virtual firewall for your network, allowing or denying traffic at the subnet level." },
  { front: "APIPA", back: "Automatic Private IP Addressing - Allows a device to assign itself a private IP address when DHCP is unavailable. Cannot communicate outside the LAN." },
  { front: "CIFS", back: "Common Internet File System - A legacy dialect of the SMB network protocol." },
  { front: "DHCP", back: "Dynamic Host Configuration Protocol - Automatically assigns IP addresses and network settings to devices." },
  { front: "DKIM", back: "DomainKeys Identified Mail - Email authentication standard that uses cryptographic signatures to protect domains from spoofing and phishing." },
  { front: "DMARC", back: "Domain-based Message Authentication, Reporting, and Conformance - Email security protocol that instructs receiving servers how to handle messages that fail SPF or DKIM checks." },
  { front: "DNS", back: "Domain Name System - Resolves hostnames to IP addresses." },
  { front: "EDR", back: "Endpoint Detection and Response - Security solution that monitors, detects, and responds to threats on endpoint devices." },
  { front: "IP", back: "Internet Protocol - Core protocol used for addressing and routing data between devices on a network." },
  { front: "LAN", back: "Local Area Network - A group of devices in the same broadcast domain." },
  { front: "MAC", back: "Media Access Control - Unique hardware address assigned to a network interface card by the manufacturer." },
  { front: "MAN", back: "Metropolitan Area Network - Network that interconnects multiple LANs across a city or campus." },
  { front: "NAT", back: "Network Address Translation - Allows multiple devices on a private network to share a single public IP address." },
  { front: "NIC", back: "Network Interface Card - Hardware component that connects a computer to a network." },
  { front: "NTP", back: "Network Time Protocol - Synchronizes clocks of computers and network devices to a common time source." },
  { front: "NFC", back: "Near Field Communication - Short-range wireless technology used for contactless payments, device pairing, and access control." },
  { front: "ONT", back: "Optical Network Terminal - Connects an ISP fiber network to the copper network in a home or office." },
  { front: "PAN", back: "Personal Area Network - Connects devices within a single user's immediate workspace." },
  { front: "RADIUS", back: "Remote Authentication Dial-In User Service - AAA protocol commonly used for network access control, VPNs, and Wi-Fi authentication." },
  { front: "RFID", back: "Radio-Frequency Identification - Wireless technology that uses electromagnetic fields to identify and track tags attached to objects or people." },
  { front: "SSID", back: "Service Set Identifier - The name of a wireless network." },
  { front: "SIEM", back: "Security Information and Event Management - Centralized collection and analysis of log files and security events." },
  { front: "SMB", back: "Server Message Block - Protocol used for sharing files, printers, and other resources over a network." },
  { front: "SPF", back: "Sender Policy Framework - Email authentication protocol that identifies which mail servers are authorized to send mail for a domain." },
  { front: "TACACS+", back: "Terminal Access Controller Access-Control System Plus - Security protocol providing centralized AAA services for network devices." },
  { front: "TCP", back: "Transmission Control Protocol - Reliable, connection-oriented transport protocol with retransmission, flow control, and packet sequencing." },
  { front: "TFTP", back: "Trivial File Transfer Protocol - Lightweight file transfer protocol commonly used for network booting and device configuration." },
  { front: "UDP", back: "User Datagram Protocol - Fast, connectionless transport protocol." },
  { front: "UTM", back: "Unified Threat Management - All-in-one network security appliance that combines multiple security functions into a single system." },
  { front: "VoIP", back: "Voice over Internet Protocol - Technology for transmitting voice communications over packet-switched networks." },
  { front: "VLAN", back: "Virtual LAN - Logically separates a physical network into multiple broadcast domains for segmentation and management." }
])

deck_3 = user_2.authored_decks.create!(
  title: "A+ 220-1102 Acronyms (A-E)",
  description: "A+ 220-1102 Acronyms outlined by the CompTIA objects handout."
)

deck_3 = deck_3.cards.create!([
  { front: "AAA", back: "Authentication, Authorization, and Accounting" },
  { front: "ACL", back: "Access Control List" },
  { front: "ADF", back: "Automatic Document Feeder" },
  { front: "AES", back: "Advanced Encryption Standard" },
  { front: "AMD", back: "Advanced Micro Devices, Inc." },
  { front: "AP", back: "Access Point" },
  { front: "APFS", back: "Apple File System" },
  { front: "APIPA", back: "Automatic Private Internet Protocol Addressing" },
  { front: "ARM", back: "Advanced RISC (Reduced Instruction Set Computer) Machine" },
  { front: "ATX", back: "Advanced Technology Extended" },
  { front: "AUP", back: "Acceptable Use Policy" },
  { front: "BEC", back: "Business Email Compromise" },
  { front: "BIOS", back: "Basic Input/Output System" },
  { front: "BNC", back: "Bayonet Neill-Concelman" },
  { front: "BSOD", back: "Blue Screen of Death" },
  { front: "BYOD", back: "Bring Your Own Device" },
  { front: "CAS", back: "Column Address Strobe" },
  { front: "CAC", back: "Calling-card Authorization Computer" },
  { front: "CIFS", back: "Common Internet File System" },
  { front: "CMDB", back: "Configuration Management Database" },
  { front: "CMOS", back: "Complementary Metal-Oxide Semiconductor" },
  { front: "CNAME", back: "Canonical Name" },
  { front: "COPE", back: "Company-Owned, Personally Enabled" },
  { front: "CPU", back: "Central Processing Unit" },
  { front: "DB-9", back: "Serial Communications D-Shell Connector, 9 pins" },
  { front: "DDoS", back: "Distributed Denial of Service" },
  { front: "DDR", back: "Double Data Rate" },
  { front: "DHCP", back: "Dynamic Host Configuration Protocol" },
  { front: "DIMM", back: "Dual In-line Memory Module" },
  { front: "DKIM", back: "DomainKeys Identified Mail" },
  { front: "DLP", back: "Data Loss Prevention" },
  { front: "DMARC", back: "Domain-based Message Authentication, Reporting, and Conformance" },
  { front: "DNS", back: "Domain Name System" },
  { front: "DoS", back: "Denial of Service" },
  { front: "DRM", back: "Digital Rights Management" },
  { front: "DSL", back: "Digital Subscriber Line" },
  { front: "DVI", back: "Digital Visual Interface" },
  { front: "ECC", back: "Error-correcting Code" },
  { front: "EDR", back: "Endpoint Detection and Response" },
  { front: "EFS", back: "Encrypting File System" },
  { front: "EOL", back: "End-of-life" },
  { front: "eSATA", back: "External Serial Advanced Technology Attachment" },
  { front: "ESD", back: "Electrostatic Discharge" },
  { front: "eSIM", back: "Embedded SIM" },
  { front: "EULA", back: "End-user License Agreement" },
  { front: "exFAT", back: "Extended File Allocation Table" }
])
