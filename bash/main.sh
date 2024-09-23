#!/bin/bash

ADDRESS_BOOK="address_book.txt"

# add new entry to the address book
add_entry() {
    echo "Enter name:"
    read name
    echo "Enter phone number:"
    read phone
    echo "Enter email:"
    read email
    
    # Save the entry to the address book file
    echo "$name|$phone|$email" >> $ADDRESS_BOOK
    echo "Entry added successfully."
}

# search an entry
search_entry() {
    echo "Enter search term (name, phone, or email):"
    read search_term
    echo "Search results:"
    grep -i "$search_term" $ADDRESS_BOOK || echo "No matching entries found."
}

# remove an entry from the address book
remove_entry() {
    echo "Enter name, phone, or email of the entry to remove:"
    read search_term
    
    # ignore special characters in the search term (was error)
    escaped_search_term=$(printf '%s' "$search_term" | sed 's/[]\/$*.^|[]/\\&/g')

    # temporary file to store remaining entries
    grep -v -i "$escaped_search_term" $ADDRESS_BOOK > temp_file && mv temp_file $ADDRESS_BOOK
    echo "Entry removed (if it existed)."
}

# main
case "$1" in
    add)
        add_entry
        ;;
    search)
        search_entry
        ;;
    remove)
        remove_entry
        ;;
    *)
        echo "Usage: $0 {add|search|remove}"
        ;;
esac
