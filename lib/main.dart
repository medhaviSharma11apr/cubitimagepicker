import 'package:cubitimagepicker/cubit/image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        create: (context) => ImageCubit(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: BlocBuilder<ImageCubit, ImageState>(builder: ((context, state) {
        if (state is ImageInitialState) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<ImageCubit>(context).pickImage();
              },
              child: const Text("Pick Image"),
            ),
          );
        } else if (state is ImageLoadedState) {
          return Center(
              child: Column(
            children: [
              Image.memory(
                state.imageBytes,
                height: 200,
              ),
              // Image.file(
              //   File(state.imagePath),
              //   height: 200,
              // ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: (() {
                    context.read<ImageCubit>().reset();
                    BlocProvider.of<ImageCubit>(context).pickImage();
                  }),
                  child: const Text('Pick Another Image'))
            ],
          ));
        } else if (state is ImageErrorState) {}
        return Center(
            child: Column(
          children: [
            const Text("Image error"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (() {
                  context.read<ImageCubit>().reset();
                  BlocProvider.of<ImageCubit>(context).pickImage();
                }),
                child: const Text('Try again'))
          ],
        ));
      })),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
