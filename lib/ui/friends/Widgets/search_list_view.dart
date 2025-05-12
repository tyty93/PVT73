import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/friends/Widgets/users_search_bar.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_card.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchListView extends StatefulWidget{
  const SearchListView({super.key});
  
  @override
  State<StatefulWidget> createState() => DisplayListViewState();  
}

class DisplayListViewState extends State<SearchListView>{
  final myController = TextEditingController();
  String query;
  bool changed = false;

  DisplayListViewState({this.query = ''});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            UsersSearchBar(
              controller: myController,

              onChanged:(value) => {
                setState(() {
                  query = myController.text;
                  changed = true;
                })
              },
            ),

            Consumer<FriendsSearchPageViewmodel>(
              builder: (context, viewModel, _){
                if(query.length < 3){
                  return SizedBox();
                }
                if(changed == true){
                  viewModel.refresh(query);
                  changed = false;
                }
                if(viewModel.users == null){
                  return const Center(child: CircularProgressIndicator());
                }
                if(viewModel.users!.isEmpty){
                  return Center(
                    child: Column(
                      children:[
                        SizedBox(height: 30,),
                        Text('Found no users called "$query"')
                      ]
                    )
                  );
                }

                final users = viewModel.users!;
                return Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height - 100 - 68,

                  child: ListView.builder(
                    itemCount: users.length,

                    itemBuilder: (context, index) {
                      return Center(
                          child: FriendsPageCard(
                            id: users[index].userId,
                            username: users[index].name,
                            userEmail: "",
                            favourite: false,
                          ),
                      );
                    } 
                  )
                );
              }
            ),
          ]
        ),
      );
  }

  void refreshListView(){
    setState(() {});
  }
}