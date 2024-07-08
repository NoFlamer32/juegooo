import speech_recognition as sr
import socket

def send_command_to_godot(command):
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.connect(('localhost', ))
        s.sendall(command.encode())

recognizer = sr.Recognizer()
mic = sr.Microphone()

while True:
    with mic as source:
        print("Listening...")
        audio = recognizer.listen(source)
    try:
        command = recognizer.recognize_google(audio, language='es-ES')
        print(f"Recognized command: {command}")
        if command.lower() in ["derecha", "izquierda"]:
            send_command_to_godot(command.lower())
    except sr.UnknownValueError:
        print("Could not understand the audio")
    except sr.RequestError as e:
        print(f"Could not request results; {e}")