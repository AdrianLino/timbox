import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../../../utils/base_color.dart';
import '../../../widget/default_button.dart';
import '../../../widget/default_textfield.dart';
import '../login_viewmodel.dart';

class LoginContent extends StatelessWidget {

      LoginViewModel vm;

      LoginContent(this.vm);

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.1),
                      Image.network(
                        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAANgAAADpCAMAAABx2AnXAAAAhFBMVEX////cPSXbOB7iZlbaKgDhX0710c3dQCn99/bbMQ/aIwDbNxzcPCLbNBfjcWXpkIb66Oburab65uTfUj/xubPaLQn1zcnqlozrnpX439zoin/bMxPlfHDmgXX98/HgWUjXAADfTTjyxcDeRjDvtK3jalzsopryvrn32NXmfnLeTDjurqcDzqjGAAAE0ElEQVR4nO2da3eiMBCGqY0KAeoVe8Hqrr3Ybv///9t62m51j0IyvgOh532+l8NTkslkJmAUEUIIIYQQQgghBMG8fxkU6zFIbGJ6QWFhYslFUFCMYoFAMYoFAsUoFggUo1ggUIxigUAxigUCxSgWCDgxcfmt8v7aL7/N130hVWaZ9KL9GUpMjq3wytq+uTOIK8Xitm9PDsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsW6BsU6h01Pk7cvthgIWTxdVSC97AL2H/llhCSVl7XCq/6CdWorZkol2bDqqrH0LAKst04xilGMYhSjGMVCFDNhiZkVSizPghJLfqpYARMbhiWG28j9DkoMuPW+rD7b27TYA8orWqYhifVmMLG7PCixPkzsugxJLL2CiUlfKNARy+9gYpsiJLFkAhMbCHMqHbHiESY2FmbBOmJmABOLgppjZooTm8lWaB2xElgav5Kt0CpiwMRDvJCpiAGXsSjayuK9ilh5AxS7lcV7FbFiAxSLZcmiipgFBsUoWovCooqYQXoJ83sNsd4lVGwuih4aYtDYEUVTUfTQEDPI2BEJC1UaYhZWovpAVB1QEOutsV7Ro+QuFMTyEVhsKtm5KIiZBVgsuhBMMgUxZGr/wUiwkuHF0ie0V7QQBHy8WPIGF5MEfLyYUfh8giDgw8WAReBvNv5jES4GrLzt3UfqPRbhYrgm7T733nERLQZPOz7wL5uixYCl0gO8G5toMaN0JvXZt1YFFsvvdbyilW++CBZD1rYP8a2bYsVUFrEPBp6PDCumFTp2eNbwoWKZ5nH2uV/Eh4qV13pevrsyqBi62HGIXzcaKQbsPB/Fa/OCFNNJE7959rkboJja4vyPxOORAcWQ/dnjTDyK3TixUnmG7fBIhXFiuCOKp9m6r2UwsQTbiTiBe68MJZaVTXhFL84ZI0rMbBsRc68RgMSA5/iqiV1nGUjM3DYkFj06mmHEEnSDpYK+244TIlZ9ETBjt1UaImbVCgLHmDgNRoRYEznHPk6DESDW6EDcsXJ5ZAAx+9KU0Rdbh2X6fLGikVzqkPv6+zpbLMUew3GkvmR1rliWtPKdhXFRt4Gpmfm1Ys1G+m829dNsVEXdEzcabT4nbmpDY15Fzd8mr215RdFS8ccmUp0unyN94XtK9fQuWv1AS/wgfGeujqxo+XcjxqXwNccaL9N4xvE/t0bDzIKPW0p4UTCz87atdgzgZlaxxefDwGLNwnheO7Bm4Xi9m9Wmjc5kIXm9x8YctJ5l6OPn5zIeCl8CP6SXtJTQnyaeCV+W3ifN1NtgAq6k3zP5R7Ju/wN+x7iWfoLmE7Ns2+AUW3tGCMnsc9v3f5rpUDzR0iK4sHHAUjjRin4DzdizeDSC4ZjZFuqHvkxn3i/RlRdhD8MvbvxiSGbVD6eguPV5aMkQ/oKRIs/GMcPq2Qb7lQjGTy5bmcysW69teLN5qN3LJGVQWxRnJnnlcp0XqmdGNYmvzUm13N61/4uzclYje1Qtt68hblB8WI3M/0ccs9K+dvlpfRHfZPtpVlbko9DzQmfma/vZvUjNn7cwd5NCXu5M0esldtmNrNCHeN7/8/ZjxiAhhBBCCCGEEEIIIYQQQgghhBBCCCHkx/EXCR56NLP4INEAAAAASUVORK5CYII=",
                        height: 200,
                      ),
                      //SizedBox(height: constraints.maxHeight * 0.1),
                      Text(
                        "¡Bienvenidos a Timbox!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      //SizedBox(height: constraints.maxHeight * 0.05),
                      Form(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                              child: DefaultTextField(
                                onChanged: (value) { vm.ChangeEmail(value); },
                                error: vm.state.email.error,
                                label: "Correo Electrónico",
                                icon: Icons.email_outlined,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                              child:DefaultTextField(
                                onChanged: (value) { vm.ChangePassword(value); },
                                obscureText: true,
                                error: vm.state.password.error,
                                label: "Contraseña",
                                icon: Icons.lock_outline,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                vm.login();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFFDC3D25),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Ingresar"),
                            ),
                            const SizedBox(height: 16.0),
                            TextButton(
                              onPressed: () {

                                Navigator.pushNamed(context, 'lostPassword');

                              },
                              child: Text.rich(
                                const TextSpan(
                                  text: "¿Olvidaste tu contraseña? ",
                                  children: [
                                    TextSpan(
                                      text: "Recuperar",
                                      style: TextStyle(color: Color(0xFF00BF6D)),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {

                                Navigator.pushNamed(context, 'register');

                              },
                              child: Text.rich(
                                const TextSpan(
                                  text: "¿No tienes cuenta? ",
                                  children: [
                                    TextSpan(
                                      text: "Registrate",
                                      style: TextStyle(color: Color(0xFF00BF6D)),
                                    ),
                                  ],
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.64),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }
    }


