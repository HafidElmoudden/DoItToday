import 'package:do_it_today/models/quote.dart';
import 'package:do_it_today/providers/random_quote.dart';
import 'package:do_it_today/providers/todos.dart';
import 'package:do_it_today/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  String? name;
  Quote? quote;
  List? todos;
  late TextEditingController todoController;

  void _getAllTodos() {
    getAllTodos().then((val) => setState(() {
          todos = val;
        }));
  }

  @override
  void initState() {
    super.initState();
    todoController = TextEditingController();
    _getAllTodos();
    SaveUser.getUserName().then((value) => setState(() {
          name = value;
        }));

    getRandomQuote().then((value) => setState(() {
          quote = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Material(
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            width: width,
            height: height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Text(
                          "Welcome Back ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "$name",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quote?.quote != null && quote?.quote != ""
                            ? quote!.quote
                            : "",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        quote?.author != null && quote?.author != ""
                            ? "- ${quote!.author}"
                            : "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey[400]),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: todoController,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Do it today, TODAY!',
                            focusColor: Colors.black,
                            hoverColor: Colors.black,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffixIcon: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  if (todoController.text.isNotEmpty) {
                                    addTodo(todoController.text, false)
                                        .then((value) {
                                      _getAllTodos();
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: todos?.length,
                      itemBuilder: (context, index) {
                        if (todos?.length == null) return null;
                        final todo = todos?[index];
                        final taskName = todo['task'];
                        final isCompleted = todo['isCompleted'];
                        return ListTile(
                          title: Text(
                            taskName,
                            style: TextStyle(
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color:
                                    isCompleted ? Colors.green : Colors.black),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    deleteTodo(index).then((value) {
                                      _getAllTodos();
                                    });
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.check_circle_sharp,
                                  color:
                                      isCompleted ? Colors.green : Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    todos?[index]['isCompleted'] = !isCompleted;
                                    updateTodo(index, !isCompleted);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
