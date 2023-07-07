# M Code formetly known as PowerQuery
These functions can be used in Power BI to fetch and/or manipulate data in Kaseya BMS.
This code is for use with Version 2 of the Kaseya BMS API

Import the M. files into PowerBI and have fun.

Please note that you will need to properly fill out the credentials in Auth_Query.m for this to work. You will need to have a service account in BMS with API access, and know your tenant name. This Auth function first generates a key with your credentials, then all subsequent queries or functions that depend on credentials will use that key.

This code only runs properly on desktop. I have not written this in a way that it will refresh the datasource in a Power BI workspace.

This is a work in progress.

Regards,
JC3K
