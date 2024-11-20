#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
# echo $($PSQL "TRUNCATE TABLE appointments, customers")

APPOINTMENT_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi

    # get available services
    AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services" | sed 's/|//')
    # if no services
    if [[ -z $AVAILABLE_SERVICES ]]
    then
        echo -e "Sorry, we're not offering any services at the moment.\n"
        return
    else
        # display available services
        echo "$AVAILABLE_SERVICES" | while read SERVICE_ID SERVICE_NAME
        do
            echo "$SERVICE_ID) $SERVICE_NAME"
        done
    fi
    
    # prompt for service id
    read SERVICE_ID_SELECTED
    # if not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
        APPOINTMENT_MENU "That is not a valid service number."
    else
        # get service id and name
        read SERVICE_ID SERVICE_NAME <<< $($PSQL "SELECT service_id, name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
        # format name for display
        SERVICE_NAME_FORMATTED=$(echo $SERVICE_NAME | sed -E 's/^\| //')
        # if not found
        if [[ -z $SERVICE_ID ]]
        then
            APPOINTMENT_MENU "I could not find that service. What would you like today?"
        else
            # prompt for phone number
            echo -e "\nWhat's your phone number?"
            read CUSTOMER_PHONE
            # get customer id and name
            read CUSTOMER_ID CUSTOMER_NAME <<< $($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")
            # if not found
            if [[ -z $CUSTOMER_ID ]]
            then
                # create new customer
                echo -e "\nI don't have a record for that phone number, what's your name?"
                read CUSTOMER_NAME
                INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
                # get freshly created customer id
                CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
            fi
            # format name for display
            CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -E 's/\|? ?([^ ]+).*/\1/')
            # prompt for service time
            echo -e "\nWhat time would you like your $SERVICE_NAME_FORMATTED, $CUSTOMER_NAME_FORMATTED?"
            read SERVICE_TIME
            # create new appointment
            INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID, '$SERVICE_TIME')")
            # display confirmation info
            echo -e "\nI have put you down for a $SERVICE_NAME_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED.\n"
        fi
    fi
}

APPOINTMENT_MENU "~~~~~ Alex's Salon ~~~~~\n\nWelcome to My Salon, how can I help you?\n"
