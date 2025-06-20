enum TypeFields { shortText, checkbox, dropDown, date, phone, email, number }

TypeFields? typeFieldFromString(String type) {
  switch (type) {
    case 'short_text':
      return TypeFields.shortText;
    case 'checkbox':
      return TypeFields.checkbox;
    case 'drop_down':
      return TypeFields.dropDown;
    case 'date':
      return TypeFields.date;
    case 'phone':
      return TypeFields.phone;
    case 'email':
      return TypeFields.email;
    case 'number':
      return TypeFields.number;
    default:
      return null;
  }
}
