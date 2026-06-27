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
