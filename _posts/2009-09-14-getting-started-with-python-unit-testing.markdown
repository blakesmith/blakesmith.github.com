---
layout: post
title: getting started with python unit testing
---

So the other day I spent a few hours trying to dive into Python unit testing.
After using unit tests at work in Ruby on Rails, I wanted to see if I
could take a stab at wrapping some code I was working on with some tests in Python. It
took me awhile to figure out how to build what I wanted, so I wanted to write
about my findings for posterity.

In this example, I have the following file structure:


<pre>
core
    -> parser.py
test
    -> suite.py
    -> test_core
        -> parser_test.py
</pre>

I wanted to have a similar structure to Ruby's testing environment. In this case:

- Code and tests in seperate high-level directories
- Each directory of code gets a corresponding directory of tests
- Each file of code gets a corresponding file of tests

I also wanted to have a single point of entry to be able to run the entire test suite. This is similar to using rake in a rails project. For this I created suite.py. By running suite.py in the test/ directory, all my tests should run. In addition, I wanted to be able to run individual tests from the command line if I wanted to.

### writing our test

If you're a firm believer in test driven development, you'll take it upon yourself to write your tests first before you write your code. I'm not going to go into the philosophical arguments of test driven development, but I will say that it's a great way to think out the expectations for your software - especially thinking through all the scenarios you want your code to be able to handle.

Our example is a basic parser function on a CommandParser object. It takes in a string and spits out a dictionary with two keys: A command followed by a list of arguments.

Here's what we expect to happen:

{% highlight python %}
>>> p = parser.CommandParser()
>>> p.line_explode('help documents stuff')
{'args': ['documents', 'stuff'], 'command': 'help'}
{% endhighlight %}

This expectation can easily be translated into a test. Here's the corresponding test for our expectations:

test/test_core/parser_test.py
{% highlight python %}
import unittest
import sys

sys.path.append("../")
sys.path.append("../../")
from core.parser import CommandParser


class TestCommandParser(unittest.TestCase):

    def setUp(self):
        self.parser = CommandParser()

    def testLineExplode(self):
        line = 'help documents stuff'
        expected = {'command': 'help', 'args': ['documents', 'stuff']}
        self.assertEqual(expected, self.parser.line_explode(line))

if __name__ == "__main__":
    unittest.main()
{% endhighlight %}

Let's walk through this. We bring in our dependencies for unit testing. Python provides the module unittest as part of the standard library. We do a sys.path.append in order to have Python search in the relative directories for classes to import. The first sys.path.append is to account for when the test is run using the suite, the 2nd is for when the test is run individually. This could probably be abstracted in some way to read cleaner, but for now it will do. We import the class we're going to test, in this case CommandParser. TestCommandParser is a subclass of unittest.TestCase and all setups, teardowns and tests are placed inside of this class. Note that you can give this class any name you wish, I usually like to keep my test classes consistant with my code classes. setUp(self) is where you place all code that should be run before each test is run. This makes it so you don't have to duplicate the same setup code in every single test. We then create a method that actually tests the workings of our function.  The line variable contains a string that represents what our example input will be. expected is the dictionary that we will match against the output of our function to make sure it is working properly. self.assertEqual is where we run our method we're trying to test and compare it's results against the expected we defined earlier. Finally, if \_\_name\_\_ == "__main__" is used to execute the test if we're running it individually from the command line.

My rule of thumb is that every function in my code class should have at least one corresponding test in the test class. I also try to have a test for every corresponding decision tree path (within reason).

### the code

After we write our test, we run it to see that it fails. Once we are satisfied that our test is failing for the reasons we expect (and not some syntax error or screw up in our actual test) we can go ahead and write the code.

core/parser.py
{% highlight python %}
class CommandParser(object):

    def line_explode(self, line):
        split = line.rsplit(" ")
        command = split[0]
        args = split[1:]
        return {'command': command, 'args': args}

{% endhighlight %}

Funny how our test is much longer than our working code eh? That's usually a good thing by my consideration. I won't really explain how this function works as I think it's pretty self explanatory.

### the test suite

Finally let's move on to the part that glues it all together. Setting up a testing suite was one of the areas I found hardest to get an in-depth example of. The standard library documentation has some explanation of it, but I didn't find it very good. For our example, the following code is the starting point for our test suite:

test/suite.py
{% highlight python %}
import unittest
import test_core.parser_test

suite = unittest.TestLoader()
suite = suite.loadTestsFromModule(test_core.parser_test)

unittest.TextTestRunner().run(suite)
{% endhighlight %}

We bring in unittest just as before. We also import the test(s) we want to run within our suite. As we add more test files, we will add more lines to the import statement. Note that once you start to reach any more than 10 or so test files, you'll probably want to do some directory globbing to import every test within a certain tree-walk, but for now let's be verbose. We instantiate a TestLoader() object and then reassign the suite varible with a new instance of itself with the unittest modules we want to run, in our case test_core.parser_test. We would also duplicate this line for every additionals module we want the test suite to run. Finally, our last command is to tell the test suite to run all of the modules within the TestLoader() object.

We can then invoke the test suite from the command line. From within the test/ directory:

{% highlight bash %}
$ python suite.py
{% endhighlight %}

### conclusion

I'm a big fan of testing, so I'm glad I went through the pains to figure out how to better use Python's unittest. While not as easy or intuitive to use as Ruby testing, it's still a good tool to have in the toolbox when you're writing Python code. I hope I was able to save you a bit of headache when trying to learn unit testing in Python. Happy coding!
