//adding the button icon in the appBar and then adding a form to get the input for adding the item in the list


import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget{
  const NewItem({super.key});

  @override
  State<NewItem> createState(){
    return _NewItemState();
  }
}


class _NewItemState extends State<NewItem>{
  //to execute the validator we use GlobalKey() to check the currentState the will be used to automatically reach out the form field and execute the validator
  final _formKey = GlobalKey<FormState>();


  void _saveItem(){
    //need to use the Global key to invoke the validator
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Item'),
      ),
        body:Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty || value.trim().length<=1 || value.trim().length >=50){
                      return 'Error Message! Must be between 1 and 50';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration:const InputDecoration(
                          label: Text('Quantity'),
                        ),
                        initialValue: '1',
                        keyboardType: TextInputType.number,
                        // here the value of the initial value  is set as a string as the formfield will return the input in the form of the string so should not be number or else
                        validator: (value){
                          if(value == null || value.isEmpty ||int.tryParse(value) == null || int.tryParse(value) !<= 0){
                            return 'Must be a valid, positive number.';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: category.value.color,
                                  ),
                                  const SizedBox(width: 8,),
                                  Text(category.value.title)
                                ],
                              ),
                            )
                        ], 
                        onChanged: (value){

                        },
                        ),
                      ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        _formKey.currentState!.reset();
                      }, 
                      child: const Text('Reset !')
                      ),
                    const SizedBox(width: 12,),
                    ElevatedButton(
                      onPressed: _saveItem, 
                      child: const Text('Add Item'),
                      )
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }
}