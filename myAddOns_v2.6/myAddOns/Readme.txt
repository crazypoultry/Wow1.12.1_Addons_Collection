myAddOns v2.6


Description
===========

myAddOns is a World of Warcraft AddOn. It's an AddOn Manager accessible from
the Main Menu. It lists your AddOns per category. You can view details and help
for the supporting AddOns and open their options window if they have one. You
can also load the load on demand AddOns and setup myAddOns to load these AddOns
automatically when you login.


Install
=======

Extract the files into your ..\World of Warcraft\Interface\AddOns directory.


Features
========

* AddOns list per category
* Automatic AddOns loading (automatic, per class, per character)
* Personal notes for each AddOn
* Localization (english, french, german)
* Low memory usage (~0.2MB)

For supporting AddOns:
* AddOns details
* AddOns help
* Link to the options window


Usage
=====

- Players -

To access the AddOn manager, click on the "AddOns" button in the Main Menu.
The AddOns list is automatic. The loaded AddOns are yellow while the AddOns not
yet loaded are grey.

You can see details and help for the AddOns in the "Details" and "Help" tabs. You
can setup the automatic load for a load on demand AddOn in the "Load" tab.


- Developers -

Here is a small tutorial to add myAddOns support to your AddOns. 

> Automatic method
myAddOns will automatically add your AddOn to the AddOns list and read its toc file
to get info about your AddOn. Here is what myAddOns uses:

	## Interface:
	## Title: <AddOn name in the AddOns list>
	## Notes: <AddOn description>
	## Version: <AddOn version>
	## X-Date: <AddOn release date>
	## Author: <Author name>
	## X-Email: <Author email address>
	## X-Website: <Author website address>
	## X-Category: <AddOn category name>
	## X-Help: <AddOn help variable name>
	## X-OptionsFrame: <AddOn options frame name>
	## RequiredDeps:
	## OptionalDeps:
	## LoadOnDemand: <loadable by myAddOns?>
	## SavedVariables:
	## SavedVariablesPerCharacter:

The category name has to be one of the following:

	- MYADDONS_CATEGORY_AUDIO
	- MYADDONS_CATEGORY_BARS
	- MYADDONS_CATEGORY_BATTLEGROUNDS
	- MYADDONS_CATEGORY_CHAT
	- MYADDONS_CATEGORY_CLASS
	- MYADDONS_CATEGORY_COMBAT
	- MYADDONS_CATEGORY_COMPILATIONS
	- MYADDONS_CATEGORY_DEVELOPMENT
	- MYADDONS_CATEGORY_GUILD
	- MYADDONS_CATEGORY_INVENTORY
	- MYADDONS_CATEGORY_MAP
	- MYADDONS_CATEGORY_OTHERS
	- MYADDONS_CATEGORY_PLUGINS
	- MYADDONS_CATEGORY_PROFESSIONS
	- MYADDONS_CATEGORY_QUESTS
	- MYADDONS_CATEGORY_RAID

If not, your AddOn will be listed in the "Unknown" cateogry.

That's all you need to register your AddOn. You don't have to add anything
in your code.

> Manual method
However if you want to override the toc values, you can register manually your
AddOn by calling the following function:

	myAddOnsFrame_Register(details, help);

The details variable is required. Use it to update the details of your AddOn.
The help variable is optional. Use it to update the help for your AddOn.

The details variable has the following structure:

	details = {
		name = "HelloWorld",
		version = "1.0",
		releaseDate = "January XX, 20XX",
		author = "Anyone",
		email = "anyone@anywhere.com",
		website = "http://www.anywhere.com",
		category = MYADDONS_CATEGORY_OTHERS,
		optionsframe = "HelloWorldOptionsFrame"
	};

The only required field is the name. It has to match the name of the directory/toc
file of your AddOn or its title in the toc file. If it doesn't an error will be
printed in the chat window and the registration will fail. This name field is used
to identify your AddOn within myAddOns. myAddOns will use the title in the toc file
to display your AddOn in the AddOns list.

The other fields are non mandatory and will overwrite the values extracted from the
toc file.

You have to use one of the global variables described above to populate the category
field. They are localized in english, french and german. If you don't, your AddOn
will be listed in the "Unknown" category.

The optionsframe field is used to detect if your AddOn has an options frame and
make a link to it. myAddOns will use the Show() function to open it.

The help variable has the following structure:

	HelloWorldHelp = {};
	HelloWorldHelp[1] = "Help Page1 line1\nline2\nline3...";
	HelloWorldHelp[2] = "Help Page2 line1\nline2\nline3...";

Each item in the table is a help page. You have to use the "\n" character to mark the
end of the lines.


FAQ
===

Q: My AddOn XYZ is not listed! Why??

A: Check if you enabled it at the character selection screen. Check if it has a
required dependency that is missing.

Q: I get the following error in my chat window: "Error during the registration of
<addon> in myAddOns.". What does it mean?

A: This error message means that the AddOn named "<addon>" is trying to register
with an unknown name/title. Check with the author if he can update his AddOn to
make it compatible with the new registration method. Anyway this has no impact on
the gameplay or on myAddOns so everything should be working okay.


Known Issues
============

* None


Versions
========

2.6 - September 3, 2006

* Fixed bug with colored AddOn names
* Added usage of toc file tags

2.5 - January 15, 2006

* Fixed scrollbar graphics glitch

2.4 - October 15, 2005

* Updated load on demand AddOns detection

2.3 - October 1, 2005

* Fixed compatibility with old registration method
* Added "Audio" category

2.2 - September 27, 2005

* Fixed error popups during registration
* Fixed bug with options windows blocking all other windows when closed

2.1 - September 26, 2005

* Fixed localization
* Fixed wordwrap
* Added automatic AddOns list
* Added "Load" button
* Added automatic AddOns loading
* Added click on address to copy it
* Added "Development" and "Unknown" categories
* Removed "Remove" button

2.0 - July 16, 2005

* Added new interface
* Added registration function
* Added AddOns details and help
* Added "Battlegrounds" and "Plugins" categories

1.2 - March 25, 2005

* Fixed highlight display
* Added "Guild" category

1.1 - March 8, 2005

* Fixed Main Menu width
* Fixed display of options windows in area other than "center"
* Added categories
* Removed slash commands

1.0 - February 4, 2005

* First version released


Contact
=======

Author : Scheid (scheid@free.fr)
Website : http://scheid.free.fr
