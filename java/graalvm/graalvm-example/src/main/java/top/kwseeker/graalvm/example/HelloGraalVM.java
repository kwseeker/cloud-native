package top.kwseeker.graalvm.example;

import java.lang.reflect.Constructor;

public class HelloGraalVM {

    public static void main(String[] args) throws Exception {
        System.out.println("Hello GraalVM!");

        //native-image 反射测试
        //1
        Constructor<Person> constructor = Person.class.getConstructor(String.class, int.class);
        Person arvin = constructor.newInstance("Arvin", 18);
        System.out.println("反射测试：" + arvin);
        //2
    }
}
