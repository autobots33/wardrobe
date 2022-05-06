import 'package:flutter/cupertino.dart';

import 'generic_dialog.dart';

Future<bool>showLogOutDialog(BuildContext context){
  return showGenericDialog<bool>(
    context:context,
    title:'Log Out',
    content:'Are you sure you want Log Out?',
    optionsBuilder:()=>{
      'Cancel':false,
      'Log Out':true,
    },
  ).then(
      (value)=>value??false,
  );
}