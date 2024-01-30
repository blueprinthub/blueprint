/* eslint-disable require-jsdoc */
import { Firestore } from "firebase-admin/firestore";
import { inject, injectable } from "tsyringe";
import { Event, PlatformId } from "../../../domain/entities";
import { EventLocalRepository } from "../../../domain/repositories/local/event.local.repository";
import { eventConverter } from "./converters/event.converter";

@injectable()
export class FirestoreEventLocalRepository implements EventLocalRepository {
  constructor(@inject("firestore") private readonly firestore: Firestore) {}

  async set(events: Event[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    events.forEach((event) => {
      const eventRef = this.firestore
        .collection("users")
        .doc(uid)
        .collection("events")
        .withConverter(eventConverter)
        .doc(`${event.access.platformId}-${event.eventId}`);
      batch.set(eventRef, event);
    });

    await batch.commit();
  }

  async remove(events: Event[], uid: string): Promise<void> {
    const batch = this.firestore.batch();
    events.forEach((event) => {
      const eventRef = this.firestore
        .collection("users")
        .doc(uid)
        .collection("events")
        .withConverter(eventConverter)
        .doc(`${event.access.platformId}-${event.eventId}`);
      batch.delete(eventRef);
    });
    await batch.commit();
  }

  async fetchFromAuthenticator(uid: string, authenticatorId: string): Promise<Event[]> {
    const eventQuerySnapshot = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("events")
      .withConverter(eventConverter)
      .where("access.authenticatorId", "==", authenticatorId)
      .get();

    const events = eventQuerySnapshot.docs.map((doc) => doc.data() as Event);
    return events;
  }

  async fetchLastFromPlatform(platform: PlatformId, uid: string): Promise<Event | undefined> {
    return undefined;
    const eventQuerySnapshot = await this.firestore
      .collection("users")
      .doc(uid)
      .collection("events")
      .withConverter(eventConverter)
      .orderBy("createdAt", "desc")
      .limit(1)
      .get();

    const eventOrUndefined = !eventQuerySnapshot.empty ? (eventQuerySnapshot.docs[0] as unknown as Event) : undefined;
    return eventOrUndefined;
  }
}
