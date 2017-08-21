---
title:  "Resource Management and Provisioning"
permalink: SSP2-resource-management.html
summary: This section describes the tasks associated with managing and provisioning your resources.
---

== Introduction

The building blocks of the platform are called *_Operinos_*. An Operino provides a container for a set of services (or *_Operino components_*) from the platform that you need for a particular application. To use the platform you need at least one Operino, although you can create as many as you need.

Once an Operino has been created, components / services can be added and configured and the whole Operino can be activated or deactivated as required.

== Create and configure an Operino

image:/images/self_service_operino_create_first_operino.png[Create first Operino]

Once you have logged into the platform, you can create your first Operino. Click on the Operinos link on the Landing page to access this functionality.

You can then create a new Operino by clicking on the *_Create a new Operino_* button.

image:/images/self_service_operino_create_operino1.png[Create Operino]

You can now name your Operino and activate immediately if you wish. Alternatively you can leave it inactive until such time that you want to use it. Click the *_Save_* button to save your Operino.

image:/images/self_service_operino_create_new_operino_component.png[Create new Operino Component]

The next step is to associate the required services with your new Operino. These are referred to as *_Operino components_*. To add the required Operino components, either click on the Operino name on the left or on the *_View_* button on the right of the Operino list and then select the *_Create a new Operino Component_* option.

You can also edit the name of the Operino on this screen or change the status by toggling the *_Active_* switch in the top right hand corner.

image:/images/self_service_operino_create_operino_component.png[Create Operino Component details]

When you select the *_Create a new Operino Component_* option, you can select and configure the required components. To start with you will just need a CDR (the *_Clinical Data Repository_* which will contain the information models artefacts and the clinical data itself) and a Demographic Service (which will allow you to add and maintain patient demographic details and very simple provider information).

The options for hosting and limits are not yet available but will be very soon.

== Amend Operino

image:/images/self_service_operino_list_operinos.png[List Operinos]

Once Operinos have been set up, they can be amended at any time. Simply display the list of Operinos from the Landing page and click either on the Operino name on the left or select the *_View_* option on the right.

image:/images/self_service_operino_amend_operino.png[Amend Operino]

The following options are available on the *_Modify Operino_* screen:

. Toggle the Active button in the top right hand corner to activate or deactivate the whole Operino.
. Edit the Operino name by selecting the *_Edit_* button.
. Add more Operino Components (services) to the existing Operino.
. Delete Operino Components (services) from the existing Operino.
. Edit the existing Operino Components (services) by clicking on the component name (e.g. CDR or Demographics) to display the details and make the required changes.
