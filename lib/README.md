# TerraVici DataViewer Context Menu Builder

The DataViewer context menu allows you to quickly launch and display a data file's charts from its right-click menu. When a .csv file is right-clicked, a customizable list of DataViewer menu items is displayed. See below for details on setting up and customizing the menu.


## Changelog

### 1.1.2
- Migrating to TerraVici GIT repo
### 1.1.1
- Changed to add context menu items to .DAT files as well as CSV
### 1.1.0
- Added uninstall feature; run app with "uninstall" argument and all DataViewer registry keys will be removed
### 1.0.8
- Added option to Retry or Cancel when attempting to restart with Admin credentials
### 1.0.7
- Added coloring of selected rows
- Removed double-click select feature due to bug (if an item is selected and another item's checkbox is double clicked, the initial selected item is checked/unchecked instead of the double-clicked item)
### 1.0.6
- Fixed credential checking
### 1.0.5
- Fixed credential checking
### 1.0.4
- Cleaned up code
- Added version (displayed on GUI)
### 1.0.3
- Improved has changed checking on GUI close
### 1.0.2
- Added grid lines to listview for better user experience
- Added check for changes on close
### 1.0.1
- Added the ability to receive the config type list from DataViewer via cmd args
- Removed dependancy on INI file; now works directly with registry
### 1.0.0
- Initial upload