# Hotel Management ER Diagram

This folder contains an entity-relationship model for a hotel-management system. The exported PDF shows the entities, attributes, and relationships used to organize hotel operations, guest bookings, accommodation, services, and event facilities.

## Files

- [Hotel-Management.pdf](Hotel-Management.pdf) - exported diagram for viewing or printing
- [Hotel-Management.drawio](Hotel-Management.drawio) - editable draw.io source

## Main Entities

- **Hotels** - identifies each hotel by name, address, and geographic area.
- **Clients** - stores client names, telephone numbers, and email addresses.
- **Employees** - records employee numbers, names, telephone numbers, departments, and positions.
- **Rooms** - describes rooms by room ID, type, nightly price, capacity, and available amenities.
- **Apartments** - represents apartment-style accommodation, including apartment ID, type, bed count, price, and additional amenities.
- **Services** - lists services offered by a hotel, including service type, name, price, and amenities.
- **Reservations** - records bookings and their dates, including check-in and check-out dates and the total price.
- **Event halls** - represents halls available for events, with hall IDs, capacity, and facilities.

## Relationships and Workflows

The model connects hotels with their accommodation, employees, services, and event halls. Clients create reservations for rooms or apartments and can also reserve event halls. Room and apartment reservations track the stay period, while event-hall reservations include the event date and related pricing. Employees support hotel operations through their department and position assignments, and hotels offer services that can be associated with a booking.

The diagram uses identifiers such as reservation ID, room ID, apartment ID, hall ID, and employee number to distinguish records and connect related entities.

## Primary Keys

The underlined attributes in the diagram identify the primary keys:

| Entity | Primary key |
| --- | --- |
| Hotels | `имеНаХотела` |
| Clients | `телефоненНомер` |
| Employees | `служебенНомер` |
| Rooms | `ID_стая` |
| Apartments | `ID_апартамент` |
| Reservations | `ID_резервация` |
| Event halls | `ID_зала` |
| Hall reservations | `ID_резервацияЗала` |

These keys uniquely identify records and are the attributes that should be used as primary-key columns when the conceptual model is converted into database tables. The diagram also shows telephone numbers and hotel names as identifying attributes in their respective entities.

## Purpose

The diagram can be used as a starting point for designing the relational database schema, identifying primary and foreign keys, and checking whether the hotel’s booking and facility-management requirements are represented before implementation.
