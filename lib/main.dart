import 'package:cubitimagepicker/cubit/Person/cubit/person_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        // create: (context) => ImageCubit(),
        create: (context) => PersonCubit(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<PersonCubit>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: context.read<PersonCubit>().nameController,
              decoration: const InputDecoration(
                  hintText: "Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  isDense: true),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: context.read<PersonCubit>().addressController,
              decoration: const InputDecoration(
                  hintText: "Address",
                  labelText: "Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  isDense: true),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: (() {
                  context.read<PersonCubit>().addPerson(
                        context.read<PersonCubit>().nameController.text,
                        context.read<PersonCubit>().addressController.text,
                      );
                }),
                child: const Text('Add employee')),
            Expanded(child: BlocBuilder<PersonCubit, PersonState>(
                builder: (context, state) {
              if (state is PersonInitialState) {
                return buildEmptylist();
              } else if (state is PersonUpdatedState) {
                return buildPersonList(state.persons);
              }
              return Container();
            })),
          ],
        ),
      ),

      //  BlocBuilder<ImageCubit, ImageState>(builder: ((context, state) {
      //   if (state is ImageInitialState) {
      //     return Center(
      //       child: ElevatedButton(
      //         onPressed: () {
      //           BlocProvider.of<ImageCubit>(context).pickImage();
      //         },
      //         child: const Text("Pick Image"),
      //       ),
      //     );
      //   } else if (state is ImageLoadedState) {
      //     return Center(
      //         child: Column(
      //       children: [
      //         Image.memory(
      //           state.imageBytes,
      //           height: 200,
      //         ),
      //         // Image.file(
      //         //   File(state.imagePath),
      //         //   height: 200,
      //         // ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         ElevatedButton(
      //             onPressed: (() {
      //               context.read<ImageCubit>().reset();
      //               BlocProvider.of<ImageCubit>(context).pickImage();
      //             }),
      //             child: const Text('Pick Another Image'))
      //       ],
      //     ));
      //   } else if (state is ImageErrorState) {}
      //   return Center(
      //       child: Column(
      //     children: [
      //       const Text("Image error"),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       ElevatedButton(
      //           onPressed: (() {
      //             context.read<ImageCubit>().reset();
      //             BlocProvider.of<ImageCubit>(context).pickImage();
      //           }),
      //           child: const Text('Try again'))
      //     ],
      //   ));
      // })),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget buildEmptylist() {
  return const Center(
    child: Text('List Is empty'),
  );
}

Widget buildPersonList(List<Person> persons) {
  return Container(
    child: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Name : ${persons[index].name}'),
            subtitle: Text('Address :${persons[index].address}'),
            trailing: IconButton(
                onPressed: (() {
                  context.read<PersonCubit>().removePerson(index);
                }),
                icon: const Icon(Icons.delete)),
          );
        }),
  );
}
