#!/bin/env bash

record_audio(){
  ffmpeg -f alsa \
  -i default \
  -ac 1 \
  audio-$(date +%H_%M_%S).wav
}

record_screen(){
  ffmpeg -y \
  -f x11grab -i :0.0 \
  -f alsa -i default \
  -ac 1 \
  -vf yadif \
  -codec:v libx264 \
  -crf 1 \
  -bf 2 \
  -flags +cgop \
  -pix_fmt yuv420p \
  -codec:a aac \
  -strict -2 \
  -b:a 384k \
  -r:a 48000 \
  video-$(date +%H_%M_%S).mov
}

capture_screen(){
	maim -f png picture-$(date +%H_%M_%S).png
}


uppass_disk(){
  address=$1

  if [ $# -eq 0 ]; then
      echo "Target disk required!"
      return 1
  fi

  sudo cryptsetup open "/dev/$address" corge
  sudo mount /dev/mapper/corge /mnt/encrypted
  sudo rsync -urvP ~/.password-store/ /mnt/encrypted/passwords/password-store/
  sudo umount /mnt/encrypted
  sudo cryptsetup close corge
}

video(){
    target=$1
    file_name=$2

    if [ $# -lt 2 ]; then
        echo "Address and name for video required!"
        echo "e.g. video address name"
        return 1
    fi

    video_format="247"

    if yt-dlp -F $target | awk '$1 == 248 {found=1} END {exit !found}'; then
        video_format="248"
    fi


    echo "proceeding to get video..."
    video="video_place_holder.webm"

    yt-dlp -f ${video_format} $target -o $video > /dev/null 2>&1 &


    echo "proceeding to get audio..."
    audio="audio_place_holder.webm"

    yt-dlp -f 251 $target -o $audio > /dev/null 2>&1 &

    wait > /dev/null 2>&1

    echo "video and audio done, proceeding to mix..."

    ffmpeg \
    -i $video \
    -i $audio \
    -c:v copy \
    -c:a copy \
    "$file_name.mkv" \
    > /dev/null 2>&1

    echo "removing extra files..."
    rm $video
    rm $audio
}

raw_video(){
  path=$1
  audio_code=$2
  video_code=$3
  video_output=$4

  if [ $# -lt 4 ]; then
      echo "Args required: path audio_code video_code video_name"
      exit 1
  fi

  # Begins with audio
  echo "Video download in progress..."
  yt-dlp -f ${audio_code} ${path} > /dev/null 2>&1 &
  audio_task_pid=$!

  audio_name=$(yt-dlp --print filename -f ${audio_code} ${path})

  # Proceed with video
  echo "Audio download in progress..."
  yt-dlp -f ${video_code} ${path} > /dev/null 2>&1 &

  video_name=$(yt-dlp --print filename -f ${video_code} ${path})

  wait $audio_task_pid


  # Convert audio
  new_audio_name="${audio_name%.*}"
  ffmpeg -i "$audio_name" "$new_audio_name.wav" > /dev/null 2>&1
  echo "Converting audio to right format..."

  wait

  # Merge audio+video
  echo "Merging video and audio"
  ffmpeg \
      -i "$video_name" \
      -i "$new_audio_name.wav" \
      -c:v copy \
      -c:a copy \
      ${video_output}.mp4 > /dev/null 2>&1


  # Remove old files
  echo "Removing old files..."
  rm "$audio_name"
  rm "$video_name"
  rm "$new_audio_name.wav"

  echo "Collection done!"
}

order=$1

if [[ ${order} == "record-screen" ]]; then
  record_screen

elif [[ ${order} == "record-audio" ]]; then
  record_audio

elif [[ ${order} == "capture-screen" ]]; then
  capture_screen

elif [[ ${order} == "uppass-disk" ]]; then
  uppass_disk ${2}

elif [[ ${order} == "video" ]]; then
  video ${2} ${3}

elif [[ ${order} == "raw-video" ]]; then
  raw_video ${2} ${3} ${4} ${5}

else
  echo "Nothing to do sir!"
fi
