---
layout: default
category: Specifications
order: 3
---

With the best possible representation of the DML purpose in mind, the
following scenarios should illustrate the interaction users should have with
the system. It is not intended to be fully complete, nor is necessarily to be
addressed within this year.

## User scenarios

Alice and Bob decided to start a service to do animal inferring from photos.
They need to do image processing for this, and they are interested in finding
out whether a Raspberry Pi is capable of such task. With this in mind they
create a project on DETI MakerLab (DML) and explain their goals and purposes.
After a professor approves their project, they're ready to make requisitions.

They then use Alice’s phone to request a Raspberry by scanning a QR code
existent in the device’s box. The team’s project is automatically updated, now
stating that a Raspberry was requested for the project and that it is
currently at Alice’s responsibility. Meanwhile, the Raspberry’s page is also
updated, indicating that one is being used in this project.

Testing the platform with evermore colleagues, Alice and Bob need something
with more power than a Raspberry. They decide to carry on tests using a DML
VM. With that in mind, Bob goes to DETI Slack to issue a VM creation with the 
`dml-servant`. After a few seconds, the servant replies, providing the 
machine’s IP address, credentials and DockerID, and thus creating a VLAN
for that project, eliminating the restrictions of UA's network.

In order to access the recently created VM, Bob gets the ID of a ethernet socket
at DETI MakerLab and issues the `dml-servant` to associate it to their project's
network. Bob is liable for this VM.

After porting their project from the RPi to the VM, the team no longer needs
their RPi. They thus scan the QR code existent in the device's box with 
DETI-MakerLab mobile app and hand it to Mr. Arez, DML’s staff. The project is 
no longer in possession of the RPi, which is reflected in the project’s
and RPi's page.

Carol, a friend of Alice, has become interested in the project after testing
it. She wants to help the team, which is happy to accept her especially since
she knows more about electronics than they do. To give Carol access to the DML
services the team is using, Alice goes to DETI-MakerLab mobile app and 
adds Carol to the project.

Since Carol is not totally familiar with the project, Bob decides to improve
their documentation in their project's page.

Finally, with the help of Carol, the team gets production ready. They have
bought hosting from another company and terminate the VM they had created.
Without having any more resources allocated to them, the team also decide to
close the project, indicating that they are no longer using DML to develop it.

## Staff scenarios

Mr. Arez is the manager of the DML room. Being responsible for maintaining
the components inside the room, keeping everything working and available, he
is constantly adding new parts that arrive and updating information about
certain items. Recently, a batch of 10 new Intel Galileos arrived, and he
wants to add them to DML’s inventory so that students can request them and
learn how to use them.

With this in mind, Mr. Arez goes to create a new product. After filling a
few generic options existent in the template provided (like the product’s
abstract, connectors, etc), he soon realises that he would like to specify a
few other characteristics, such as that there is an integrated RTC which
requires a 3V battery, a programmable EEPROM, and so on. He thus adds new
sections to the item’s page, resembling the structure he found on the
product’s datasheet.

Happy with the result, Mr. Arez creates the Galileo’s product page.

Now, he wants to make available the different units he received (the actual
items). He goes to the Galileo’s page and chooses to add new units of the
product, by selecting the number of units he wants to add and all the codes are
quickly generated so that Mr. Arez can print them on a nearby printer.
Soon he has added all 10 new Galileos, and can make them available for students.

