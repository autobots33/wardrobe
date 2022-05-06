

import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<bool>showDeleteDialog(BuildContext context){
  return showGenericDialog<bool>(
    context:context,
    title:'Delete',
    content:'Are you sure you want Delete this item?',
    optionsBuilder:()=>{
      'Cancel':false,
      'Log Out':true,
    },
  ).then(
        (value)=>value??false,
  );
}